require 'spec_helper'

module InfinityTest
  describe Options do

    context "when parsing" do

      it "should parse --rspec and return rspec" do
        parse_options('--rspec')
        @options[:test_framework].should equal :rspec
      end

      it "should not return rspec as test framework when not parse rspec" do
        parse_options('--test-unit')
        @options[:test_framework].should_not equal :rspec
      end

      it "should parse --bacon and return bacon" do
        parse_options('--bacon')
        @options[:test_framework].should equal :bacon
      end

      it "should not parse --test-unit" do
        parse_options('--rspec')
        @options[:test_framework].should_not equal :bacon
      end

      it "should parse --test-unit and return test_unit" do
        parse_options('--test-unit')
        @options[:test_framework].should equal :test_unit
      end

      it "should not parse --test-unit" do
        parse_options('--rspec')
        @options[:test_framework].should_not equal :test_unit
      end

      it "should parse --rvm-versions and return an array" do
        parse_options('--rubies=1.8.6,1.8.7')
        @options[:rubies].should eql '1.8.6,1.8.7'
      end

      it "should parse --rvm-versions with dashes" do
        parse_options('--rubies=1.8.7-p249,1.9.1-p378')
        @options[:rubies].should eql '1.8.7-p249,1.9.1-p378'
      end

      it "should parse --rvm-versions with particual options" do
        parse_options('--rubies=jruby-6.6.6+-J-cp bar/whisky-in-the.jar:.')
        @options[:rubies].should eql 'jruby-6.6.6'
      end

      it "should parse --rvm-versions specific options" do
        parse_options('--rubies=jruby-6.6.6+-J-cp bar/whisky-in-the.jar:.')
        @options[:specific_options].should == {'jruby-6.6.6' => '-J-cp bar/whisky-in-the.jar:.'}
      end

      it "should parse rubies with multiples specific options" do
        parse_options('--rubies=jruby-1+-J-cp :.,jruby-2+-J-cp,1.9.2,jruby3+-J-cp :.')
        @options[:rubies].should == 'jruby-1,jruby-2,1.9.2,jruby3'
      end

      it "should parse particular options with multiples specific options" do
        parse_options('--rubies=jruby-1+-J-cp :.,jruby-2+-J-cp,1.9.2,jruby3+-J-cp :.')
        @options[:specific_options].should == {'jruby-1'=>'-J-cp :.','jruby-2'=>'-J-cp','1.9.2'=>nil,'jruby3'=>'-J-cp :.'}
      end

      it "should parse --verbose" do
        parse_options('--verbose')
        @options[:verbose].should be_true
      end

      it "should parse --skip-bundler" do
        parse_options('--skip-bundler')
        @options[:skip_bundler?].should be_true
      end

      it "should return false for --skip-bundler option" do
        parse_options('--rails')
        @options[:skip_bundler?].should be_false
      end

      it "should  return rails as app framework when  parse rails" do
        parse_options('--rails')
        @options[:app_framework].should equal :rails
      end

      it "should return rubygems as app framework when parse rubygems" do
        parse_options('--rubygems')
        @options[:app_framework].should equal :rubygems
      end

      # it "should parse the cucumber option" do
      #   pending
      #   parse_options('--cucumber')
      #   @options[:cucumber].should be_true
      # end

      it "should parse the patterns options" do
        parse_options('--heuristics')
        @options[:show_heuristics?].should be_true
      end
      
      it 'should parse the generate file options' do
        parse_options('--generate-file')
        @options[:generate_file].should be_true
      end
      
      it 'generate_file shoudl be false as defaults' do
        parse_options('--heuristics')
        @options[:generate_file].should be_false
      end

    end

    def parse_options(*arguments)
      @options = InfinityTest::Options.new(arguments)
    end

  end
end
