#
FROM ruby:3.4.2
ARG CRON_SETTING="*/30 * * * *"
ARG ZREVIEWTENDER_COMMAND="-r"
ENV ZREVIEWTENDER_COMMAND ${ZREVIEWTENDER_COMMAND}
ENV WORKDIR=/usr/src/app
workdir $WORKDIR

RUN apt-get update && apt-get install -y cron && apt-get install -y vim

COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add crontab file
RUN echo "#!/bin/sh" >> ./cron.sh
RUN echo "export GEM_HOME=$GEM_HOME" >> ./cron.sh
RUN echo "export PATH=$PATH" >> ./cron.sh
RUN echo "cd ${WORKDIR} && bundle exec bin/ZReviewTender ${ZREVIEWTENDER_COMMAND} >> /dev/null 2>&1" >> ./cron.sh
RUN chmod +x ./cron.sh
RUN echo "$CRON_SETTING sh ${WORKDIR}/cron.sh" >> /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

CMD bundle exec bin/ZReviewTender ${ZREVIEWTENDER_COMMAND} && cron -f

## Build: docker build -t zreviewtender:latest --build-arg CRON_SETTING="*/30 * * * *" --build-arg ZREVIEWTENDER_COMMAND="-r" .
## Run: docker run -v ./:/usr/src/app zreviewtender