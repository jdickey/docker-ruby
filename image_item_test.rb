# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/spec'

require_relative './image_item'

describe ImageItem do
  let(:default_image_version) { '9.99.0' }
  let(:default_ruby_version) { '2.5.1' }
  let(:valid_params) do
    {
      base_os: 'slim-stretch',
      image_version: default_image_version,
      qt: 'qt',
      ruby_version: default_ruby_version,
      tags: ['2.5-stretch-slim-qt', 'stretch-slim-qt']
    }
  end

  describe '#initialize' do
    describe 'requires parameters for' do
      it 'base_os' do
        valid_params.delete :base_os
        expect { ImageItem.new(valid_params) }.must_raise ArgumentError
      end

      it ':image_version' do
        valid_params.delete :image_version
        expect { ImageItem.new(valid_params) }.must_raise ArgumentError
      end

      it 'qt' do
        valid_params.delete :qt
        expect { ImageItem.new(valid_params) }.must_raise ArgumentError
      end

      it 'ruby_version' do
        valid_params.delete :ruby_version
        expect { ImageItem.new(valid_params) }.must_raise ArgumentError
      end

      it 'tags' do
        valid_params.delete :tags
        expect { ImageItem.new(valid_params) }.must_raise ArgumentError
      end
    end # describe 'requires parameters for'

    describe 'accepts parameters for' do
      it 'latest' do
        valid_params[:latest] = true
        obj = ImageItem.new valid_params
        expect(obj.latest?).must_equal true
      end
    end # describe 'accepts parameters for'

    it 'freezes the new object' do
      expect(ImageItem.new(valid_params)).must_be :frozen?
    end
  end # describe '#initialize'

  describe 'has reader methods for' do
    it 'base_os' do
      valid_params[:base_os] = 'some-other-string'
      expect(ImageItem.new(valid_params).base_os).must_equal 'some-other-string'
    end

    it 'image_version' do
      obj = ImageItem.new(valid_params)
      expect(obj.image_version).must_equal default_image_version
    end

    describe 'qt?, such that when initialised with' do
      it '"qt", the #qt reader returns true' do
        valid_params[:qt] = 'qt'
        expect(ImageItem.new(valid_params).qt?).must_equal true
      end

      it '"no-qt", the #qt reader returns false' do
        valid_params[:qt] = 'no-qt'
        expect(ImageItem.new(valid_params).qt?).must_equal false
      end
    end # describe 'qt?, such that when initialised with'

    it 'ruby_version' do
      obj = ImageItem.new(valid_params)
      expect(obj.ruby_version).must_equal default_ruby_version
    end

    describe 'tags' do
      it 'that returns a frozen array of strings' do
        obj = ImageItem.new(valid_params)
        expect(obj.tags).must_be :frozen?
      end

      it 'when initialised with a single string, returns an array' do
        valid_params[:tags] = 'some-other-tag'
        obj = ImageItem.new(valid_params)
        other_tag = [:ruby_version, :base_os].map do |attr|
          valid_params[attr]
        end.join('-')
        expect(obj.tags).must_equal [other_tag, 'some-other-tag']
      end
    end # 'tags'

    describe 'latest? such that' do
      it 'defaults to false' do
        obj = ImageItem.new valid_params
        expect(obj.latest?).must_equal false
      end

      it 'can be set to true' do
        valid_params[:latest] = true
        obj = ImageItem.new valid_params
        expect(obj.latest?).must_equal true
      end
    end # describe 'latest? such that'
  end # describe 'has reader methods for'

  describe '#build_tag_name' do
    it 'returns the correct build tag for the initialised parameters' do
      expected = [:ruby_version, :base_os].map do |part|
        valid_params[part]
      end.join('-')
      expected += '-no-qt' unless valid_params[:qt] == 'qt'
      expect(ImageItem.new(valid_params).build_tag_name).must_equal expected
    end
  end # describe '#build_tag_name'

  describe '#debian?' do
    describe 'returns true for a base_os value of' do
      after do
        expect(ImageItem.new(valid_params).debian?).must_equal true
      end

      it 'slim-jessie' do
        valid_params[:base_os] = 'slim-jessie'
      end

      it 'slim-stretch' do
        valid_params[:base_os] = 'slim-stretch'
      end

      it 'jessie' do
        valid_params[:base_os] = 'jessie'
      end

      it 'stretch' do
        valid_params[:base_os] = 'stretch'
      end
    end # describe 'returns true for a base_os value of'

    describe 'returns false for a base_os value of' do
      after do
        expect(ImageItem.new(valid_params).debian?).must_equal false
      end

      it 'alpine3.7' do
        valid_params[:base_os] = 'alpine3.7'
      end
    end # describe 'returns false for a base_os value of'
  end # describe '#debian?'

  describe '#alpine?' do
    describe 'returns false for a base_os value of' do
      after do
        expect(ImageItem.new(valid_params).alpine?).must_equal false
      end

      it 'slim-jessie' do
        valid_params[:base_os] = 'slim-jessie'
      end

      it 'slim-stretch' do
        valid_params[:base_os] = 'slim-stretch'
      end

      it 'jessie' do
        valid_params[:base_os] = 'jessie'
      end

      it 'stretch' do
        valid_params[:base_os] = 'stretch'
      end
    end # describe 'returns false for a base_os value of'

    describe 'returns true for a base_os value of' do

      after do
        expect(ImageItem.new(valid_params).alpine?).must_equal true
      end

      it 'alpine3.7' do
        valid_params[:base_os] = 'alpine3.7'
      end
    end # describe 'returns true for a base_os value of'
  end # describe '#alpine?'

  describe '#upgrade_cmd returns the correct string when the base_os is' do
    let(:alpine_upgrade) { 'apk --no-cache upgrade' }
    let(:debian_upgrade) do
      ['apt-get update -qq', 'apt-get dist-upgrade -y', 'apt-get clean',
       'find /var/lib/apt/lists/* -delete'
      ].join(' && ')
    end

    it '#alpine?' do
      valid_params[:base_os] = 'alpine3.7'
      expect(ImageItem.new(valid_params).upgrade_cmd).must_equal alpine_upgrade
    end

    it '#debian?' do
      valid_params[:base_os] = 'stretch'
      expect(ImageItem.new(valid_params).upgrade_cmd).must_equal debian_upgrade
    end
  end # describe '#upgrade_cmd returns the correct string when the base_os is'

  describe '#base_image_spec' do
    describe 'when initialised with the :qt param set to' do
      describe 'qt' do
        it 'does not include the "-no-qt" suffix' do
          valid_params.merge! base_os: 'stretch', qt: 'qt'
          regex = /\-stretch$/
          actual = ImageItem.new(valid_params).base_image_spec.match?(regex)
          expect(actual).must_equal true
        end
      end # describe 'qt'

      describe 'no-qt' do
        it 'includes the "-no-qt" suffix' do
          valid_params.merge! base_os: 'stretch', qt: 'no-qt'
          regex = /\-stretch\-no\-qt$/
          actual = ImageItem.new(valid_params).base_image_spec.match?(regex)
          expect(actual).must_equal true
        end
      end # describe 'no-qt'
    end # describe 'when initialised with the :qt param set to'
  end # describe '#base_image_spec'

  describe '#maintainer' do
    describe 'by default' do
      it 'has the default :maintainer information' do
        expected = 'Jeff Dickey <jdickey at seven-sigma dot com>'
        expect(ImageItem.new(valid_params).maintainer).must_equal expected
      end
    end # describe 'by default'

    it 'when initialised with a :maintainer param specified' do
      expected = 'Some Other Maintainer'
      valid_params[:maintainer] = expected
      expect(ImageItem.new(valid_params).maintainer).must_equal expected
    end
  end # describe '#maintainer'
end
