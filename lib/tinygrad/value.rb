# frozen_string_literal: true

module TinyGrad
  # Base value object for the DAG
  class Value
    attr_reader :data, :children, :op
    attr_accessor :label

    # rubocop:disable Naming/MethodParameterName
    def initialize(data, children: [], op: '', label: '')
      @data = data.to_f

      @children = children
      @op = op
      @label = label
    end
    # rubocop:enable Naming/MethodParameterName

    def +(other)
      raise_error_if_not_value(other, '+')

      Value.new(@data + other.data, children: [self, other], op: '+')
    end

    def *(other)
      raise_error_if_not_value(other, '*')

      Value.new(@data * other.data, children: [self, other], op: '*')
    end

    def to_s
      "Value(data: #{@data})"
    end

    private

    def raise_error_if_not_value(other, operator)
      raise ArgumentError, "right value of '#{operator}' is not a Value" unless other.is_a?(Value)
    end
  end
end