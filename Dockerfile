FROM justinclayton/ubuntu1304-rbenv-ruby:193

WORKDIR /tmp/testing
ADD . /tmp/testing/
RUN bundle install && rbenv rehash
RUN bundle exec rake spec
RUN bundle exec rake spec_prep && bundle exec puppet apply -v -e "include awscli" --modulepath "spec/fixtures/modules"
RUN bundle exec rake serverspec
