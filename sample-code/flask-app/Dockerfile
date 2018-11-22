FROM alpine:3.6

# Install python and pip
RUN apk add --update python3

# install Python modules needed by the Python app
COPY . /usr/src/app/
RUN pip3 install --no-cache-dir -r /usr/src/app/requirements.txt

# tell the port number the container should expose
EXPOSE 5000

CMD python3 /usr/src/app/app.py
