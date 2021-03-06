require "duplo/version"
require "set"

module Duplo

  TOYS = {
    "a" => Array,
    "s" => Set,
    "h" => Hash
  }

  BRICK = /[#{TOYS.keys.join}]\d*/

  class << self

    attr_writer :default_size

    def default_size
      @default_size || 5
    end

    def add(toy, part)
      case toy
      when Array, Set
        toy << part
      when Hash
        toy.store(toy.size, part)
      end
    end

    def can_build?(toy)
      !!(toy.strip =~ /\A#{BRICK}+\z/)
    end

    def build(part, path = [], &block)
      raise %(Don't know how to build "#{part}", sorry) unless can_build? part

      part = part.dup
      brick = part.slice! BRICK
      type, size = crack brick
      toy = type.new

      if part.empty?
        block ||= proc { |path| path.is_a?(Array) ? path.last : path }
        size.times { |i| add toy, block.call(path.empty? ? i : path + [i]) }
      else
        size.times { |i| add toy, build(part, path + [i], &block) }
      end

      toy
    end

    def smash(toy)
      toy.scan(BRICK).map { |brick| crack brick }
    end

    def crack(brick)
      type, size = brick.split("", 2)
      size = size.empty? ? default_size : size.to_i
      [TOYS[type], size]
    end

    def spell(toy)
      smash(toy).map.with_index do |(type, size), idx|
        plural = idx == 0 ? "" : type == Hash ? "es" : "s"
        size.zero? ? "empty #{type}#{plural}" : "#{size}-element #{type}#{plural}"
      end.join(" containing ")
    end
  end

  module_function

  def respond_to_missing?(method_name, *)
    toy = method_name.to_s
    Duplo.can_build?(toy) || super
  end

  def method_missing(method_name, *arguments, &block)
    toy = method_name.to_s
    if Duplo.can_build? toy
      Duplo.build toy, *arguments, &block
    else
      super
    end
  end
end
