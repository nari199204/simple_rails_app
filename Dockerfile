# Use the official Ruby image with the correct version
FROM ruby:3.3.6

# Set environment variables
ENV RAILS_ENV=development \
    NODE_ENV=development

# Set the working directory
WORKDIR   /app/Rails8demo

# Install required packages
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm

# Install Bundler
RUN gem install bundler

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 5

# Copy the entire application code
COPY . .

# Expose the port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
