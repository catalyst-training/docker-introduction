FROM alpine:3.6

# Install python and pip
RUN apk add --update python3

# install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r /usr/src/app/requirements.txt

# copy files required for the app to run
COPY app.py /usr/src/app/
RUN mkdir -p /usr/src/app/tests
COPY tests/ /usr/src/app/tests
COPY templates/index.html /usr/src/app/templates/

# tell the port number the container should expose
EXPOSE 5000

ENTRYPOINT ["python3"]
CMD ["/usr/src/app/app.py"]
