module WordProcess
  extend ActiveSupport::Concern

  module ClassMethods
    @@proc = Proc.new {|val, old, new| old+new }

    def sadness_calculator(text_hash)
      sadness = text_hash.inject(0) do |count, elem|
        res = Word.where(word: elem[0]).first.sadness
        count + res*elem[1]
      end
      [sadness,Word.word_count(text_hash),Word.sadness_map(text_hash)]
    end

    def missed_words(text_hash)
      text_hash.collect do |elem|
        elem[0] if (where(word: elem[0]).empty? || sadness_missed?(elem[0]))
      end.compact || []
    end

    def sadness_missed?(word)
      test_word = Word.where(word: word).first
      (test_word[:sadness] ? false : true) unless test_word.nil?
    end

    def word_count(text_hash)
      text_hash.inject(0) do |count, elem|
        if where(word: elem[0]).first.sadness!=0
          count + elem[1]
        else
          count
        end
      end
    end

    def sadness_map (text_hash)
      sadness_map = [0,0,0,0,0]
      text_hash.each do |key, value|
        res = Word.where(word: key).first
        if( res!= nil and res[:sadness] !=nil)
          sadness_map[(res[:sadness])+2] += value
        end
      end
      sadness_map
    end


    def text_to_words(text)
      text_hash = Hash.new(0)
      # proc = Proc.new {|val, old, new| old+new }
      text.downcase.scan(/(\w+([-'.]\w+)*)/) do |word, ignore|
        split_words = nil
        case word
          when "i'll"
            split_words = 'i will'
          when "i'm"
            split_words = 'i am'
          when "i've"
            split_words = 'i have'
          when "you've"
            split_words = 'you have'
          when "didn't"
            split_words = 'did not'
          when "don't"
            split_words = 'do not'
          when "doesn't"
            split_words = 'does not'
          when "you're"
            split_words = 'you are'
          when "they're"
            split_words = 'they are'
          when "they'll"
            split_words = 'they will'
          when "it's"
            split_words = 'it is'
          when "it'll"
            split_words = 'it will'
          when "that's"
            split_words = 'that is'
          when "there's"
            split_words = 'there is'
          when "they'd"
            split_words = 'they had'
          when "he's"
            split_words = 'he is'
          when "can't"
            split_words = 'can not'
          when "couldn't"
            split_words = 'could not'
          when "ain't"
            split_words ='are not'
          when "aren't"
            split_words = 'are not'
          when "we'll"
            split_words = 'we will'
          when "you'll"
            split_words = 'you will'
          when "we'd"
            split_words = 'we would'
          when "we're"
            split_words = 'we are'
          when "we've"
            split_words = 'we have'
          when "what's"
            split_words = 'what is'
          when "won't"
            split_words = 'will not'
          when "reaper's"
            split_words = 'reaper is'
          when "you'd"
            split_words = 'you would'
          when "i'd"
            split_words = 'i would'
          when "isn't"
            split_words = 'is not'
          when "let's"
            split_words = 'let us'
          when "life's"
            split_words = 'life is'
          when "here's"
            split_words = 'here is'
          when "she's"
            split_words = 'she is'
          when "she'll"
            split_words = 'she will'
          when "everybody's"
            split_words = 'everybody is'
          else
            text_hash[word] += 1
        end
        text_hash.merge!((text_to_words split_words), &@@proc) if split_words
      end
      text_hash
    end

  end
end