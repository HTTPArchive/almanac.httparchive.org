ARG     PYTAG=3
FROM    python:${PYTAG}

# Enable unbuffered STDOUT logging
ENV     PYTHONUNBUFFERED=1

ARG     NODEVER=12.x
RUN     curl -sL https://deb.nodesource.com/setup_${NODEVER} | bash - \
        && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
        && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN     apt update && apt install -y \
          google-cloud-sdk \
          nodejs \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY    requirements.txt package*.json ./
RUN     pip install -r requirements.txt
RUN     npm install
COPY    . ./

CMD     ["python", "main.py"]
