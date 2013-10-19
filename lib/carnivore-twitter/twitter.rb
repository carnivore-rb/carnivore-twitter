require 'twitter'
require 'carnivore/source'

module Carnivore
  class Source
    class Twitter < Source

      class UserStream

        include Celluloid

        attr_reader :tweets
        attr_reader :connection

        def initialize(connection)
          require 'thread'
          @tweets = Queue.new
          @connection = connection
        end

        def start
          @connection.user do |tweet|
            @tweets << tweet
          end
        end
      end

      attr_reader :client
      attr_reader :streamer
      attr_reader :twit
      attr_reader :streaming
      attr_reader :poll_pause
      attr_accessor :last_id

      def setup(args={})
        @twit = args[:user_timeline]
        @streaming args[:streaming]
        @last_id = nil
        @poll_pause = args[:polling_wait] || 60
        @client = Twitter::REST::Client.new do |c|
          c.consumer_key = args[:consumer_key]
          c.consumer_secret = args[:consumer_secret]
          c.access_token = args[:access_token]
          c.access_token_secret = args[:access_token_secret]
        end
        if(streaming)
          @streamer = Twitter::Streaming::Client.new do |c|
            c.consumer_key = args[:consumer_key]
            c.consumer_secret = args[:consumer_secret]
            c.access_token = args[:access_token]
            c.access_token_secret = args[:access_token_secret]
          end
        end
      end

      def get_timeline(args={})
        if(twit)
          client.user_timeline(twit, args)
        else
          client.home_timeline(args)
        end
      end

      def init_timeline
        unless(last_id)
          last_id = get_timeline(:count => 1).first.id
        end
      end

      def init_stream
        unless(user_stream)
          supervise_as "#{name}_steam".to_sym, UserStream, streamer
        end
      end

      def user_stream
        Celluloid::Actor["#{name}_stream".to_sym]
      end

      def receive(*args)
        streaming ? receive_stream : receive_request
      end

      def receive_request
        init_timeline
        messages = []
        while(messages.empty?)
          timeline = get_timeline(:since_id => last_id)
          if(timeline.empty?)
            debug 'No new events on timeline'
            sleep(poll_pause)
          else
            messages = timeline
          end
        end
        messages.map(&:to_hash)
      end

      def receive_stream
        init_stream
        user_stream.tweets.pop.to_hash
      end

      def transmit(payload, original=nil)
        debug "Sending #{payload} to client #{client}"
        client.update(payload)
      end

    end
  end
end