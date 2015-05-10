require "spec_helper"

describe Duplo do

  let(:default_size)   { Duplo.default_size }
  let(:valid_bricks)   { %w[a aa s ss h hh a0 a1h a2s33h44] }
  let(:invalid_bricks) { %w[A n 0 11 1s a2s33t44] }

  it "has a version number" do
    expect(Duplo::VERSION).not_to be nil
  end

  describe ".abc" do
    it "provides alphabet" do
      expect(Duplo.abc).to eq ("a".."z").to_a
      expect(Duplo.abc 4).to eq ("a".."d").to_a
    end
  end

  describe ".respond_to?" do
    it "returns true for valid bricks" do
      valid_bricks.each do |brick|
        expect(Duplo.respond_to? brick).to be true
      end
    end

    it "returns false for invalid bricks" do
      invalid_bricks.each do |brick|
        expect(Duplo.respond_to? brick).to be false
      end
    end
  end

  describe ".can_build?" do
    it "can build valid bricks" do
      valid_bricks.each do |brick|
        expect(Duplo.can_build? brick).to be true
      end
    end

    it "cannot build invalid bricks" do
      invalid_bricks.each do |brick|
        expect(Duplo.can_build? brick).to be false
      end
    end
  end

  describe ".build" do
    let(:bricks) do
      {
        "a"      => [0, 1, 2, 3, 4],
        "h"      => { 0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4 },
        "a2a3"   => [[0, 1, 2]] * 2,
        "a3s2"   => [[0, 1].to_set] * 3,
        "a2h3"   => [{ 0 => 0, 1 => 1, 2 => 2 }, { 0 => 0, 1 => 1, 2 => 2 }],
        "a2h3s4" => [{ 0 => (0..3).to_set, 1 => (0..3).to_set, 2 => (0..3).to_set }] * 2
      }
    end

    it "builds toys from bricks" do
      bricks.each do |brick, toy|
        expect(Duplo.build brick).to eq toy
      end
    end

    it "raises error when given invalid brick" do
      invalid_bricks.each do |brick|
        expect { Duplo.build brick }.to raise_error
      end
    end
  end

  describe ".smash" do
    let(:bricks) do
      {
        "a"       => [[Array, default_size]],
        "aa"      => [[Array, default_size], [Array, default_size]],
        "a2a"     => [[Array, 2],  [Array, 5]],
        "a2h0"    => [[Array, 2],  [Hash, 0]],
        "a22h3s4" => [[Array, 22], [Hash, 3], [Set, 4]]
      }
    end

    it "smashes bricks, rawr!" do
      bricks.each do |brick, parts|
        expect(Duplo.smash brick).to eq parts
      end
    end
  end

  describe ".spell" do
    let(:bricks) do
      {
        "a"       => "5-element Array",
        "aa"      => "5-element Array containing 5-element Arrays",
        "a2h0"    => "2-element Array containing empty Hashes",
        "a22h3s4" => "22-element Array containing 3-element Hashes containing 4-element Sets"
      }
    end

    it "spells bricks properly" do
      bricks.each do |brick, description|
        expect(Duplo.spell brick).to eq description
      end
    end
  end
end
