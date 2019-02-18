# Base image
FROM ruby:2.4.5

# Setup environment variables that will be available to the instance
ENV APP_HOME /produciton



RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -qq -y build-essential nodejs yarn \
  libpq-dev --fix-missing --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.0.1

# Create a directory for our application
# and set it as the working directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add our Gemfile
# and install gems
ADD Gemfile* $APP_HOME/
RUN bundle install
RUN yarn install

# Copy over our application code
ADD . $APP_HOME

# Run our app
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0'
