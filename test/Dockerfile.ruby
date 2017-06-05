from dkundel/sslaunch

RUN gem install bundler

WORKDIR /sdk-starter-kits/ruby

RUN echo "Downloading SDK Starter Ruby"
RUN wget -O ruby.zip "https://github.com/TwilioDevEd/sdk-starter-ruby/archive/master.zip"

RUN echo "Unzipping SDK Starter Ruby"
RUN unzip ruby.zip
RUN rm ruby.zip

WORKDIR /sdk-starter-kits/ruby/sdk-starter-ruby-master
RUN ls -l
RUN cp .env.example .env

EXPOSE 4567
RUN bundle install

CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0"]