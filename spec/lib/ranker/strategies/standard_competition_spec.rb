require 'spec_helper'

describe Ranker::Strategies::StandardCompetition do
  let(:klass) { Ranker::Strategies::StandardCompetition }

  describe :methods do

    describe :rank do
      let(:values) { raise ArgumentError }
      let(:strategy) { klass.new(values) }
      let(:rankings) { strategy.rank }
      subject { rankings }

      context 'when list of values is large' do
        let(:values) { [1, 1, 2, 3, 3, 4, 5, 6, 7, 7, 7, 1, 1, 3] }
        it { should have(7).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:score) { should == 7 }
          its(:values) { should == [7, 7, 7] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:score) { should == 6 }
          its(:values) { should == [6] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 5 }
          its(:score) { should == 5 }
          its(:values) { should == [5] }
        end

        context '4th ranking' do
          let(:ranking) { rankings[3] }
          subject { ranking }
          its(:rank) { should == 6 }
          its(:score) { should == 4 }
          its(:values) { should == [4] }
        end

        context '5th ranking' do
          let(:ranking) { rankings[4] }
          subject { ranking }
          its(:rank) { should == 7 }
          its(:score) { should == 3 }
          its(:values) { should == [3, 3, 3] }
        end

        context '6th ranking' do
          let(:ranking) { rankings[5] }
          subject { ranking }
          its(:rank) { should == 10 }
          its(:score) { should == 2 }
          its(:values) { should == [2] }
        end

        context '7th ranking' do
          let(:ranking) { rankings[6] }
          subject { ranking }
          its(:rank) { should == 11 }
          its(:score) { should == 1 }
          its(:values) { should == [1, 1, 1, 1] }
        end

      end # list of values is large

      context 'when list of values is small' do
        let(:values) { [3, 2, 2, 1] }
        it { should have(3).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:values) { should == [3] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:values) { should == [2, 2] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:values) { should == [1] }
        end

      end # list of values is small

      context 'when ranking with a non-default selector' do
        let(:value_1) { Array.new(3) }
        let(:value_2) { Array.new(2) }
        let(:value_3) { Array.new(2) }
        let(:value_4) { Array.new(1) }
        let(:values) { [value_1, value_2, value_3, value_4] }
        let(:strategy) { klass.new(values, scorer: lambda { |value| value.count }) }
        it { should have(3).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:values) { should == [value_1] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:values) { should == [value_2, value_3] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:values) { should == [value_4] }
        end

      end # when ranking with a block

    end # rank

  end # methods

end
