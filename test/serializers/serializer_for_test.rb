require 'test_helper'

module ActiveModel
  class Serializer
    class SerializerForTest < Minitest::Test
      class ArraySerializerTest < Minitest::Test
        def setup
          @array = [1, 2, 3]
          @previous_array_serializer = ActiveModel::Serializer.config.array_serializer
        end

        def teardown
          ActiveModel::Serializer.config.array_serializer = @previous_array_serializer
        end

        def test_serializer_for_array
          serializer = ActiveModel::Serializer.serializer_for(@array)
          assert_equal ActiveModel::Serializer.config.array_serializer, serializer
        end

        def test_overwritten_serializer_for_array
          new_array_serializer = Class.new
          ActiveModel::Serializer.config.array_serializer = new_array_serializer
          serializer = ActiveModel::Serializer.serializer_for(@array)
          assert_equal new_array_serializer, serializer
        end
      end

      class SerializerTest <  Minitest::Test
        def setup
          @profile = Profile.new
          @model = ::Model.new
        end

        def test_serializer_for_existing_serializer
          serializer = ActiveModel::Serializer.serializer_for(@profile)
          assert_equal ProfileSerializer, serializer
        end

        def test_serializer_for_not_existing_serializer
          serializer = ActiveModel::Serializer.serializer_for(@model)
          assert_equal nil, serializer
        end
      end
    end
  end
end