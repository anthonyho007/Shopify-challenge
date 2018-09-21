FROM gcr.io/google_appengine/ruby

RUN cd /rbenv/plugins/ruby-build && \
    git pull && \
    rbenv install -s 2.5.1 && \
    rbenv global 2.5.1 && \
    gem install -q --no-rdoc --no-ri bundler --version 1.16.4
ENV RBENV_VERSION 2.5.1

COPY . /app/

RUN bundle install --deployment && rbenv rehash

ENV RACK_ENV=production \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true

ENTRYPOINT []

CMD bundle exec foreman start --formation "$FORMATION"