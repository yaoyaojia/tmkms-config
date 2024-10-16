FROM --platform=linux/amd64 rust:bookworm
WORKDIR /root/tmkms
RUN cargo install tmkms --features=softsign
RUN tmkms init config
COPY ./priv_validator_key.json ./config/secrets 
COPY ./tmkms.toml  ./config
RUN tmkms softsign import ./config/secrets/priv_validator_key.json $HOME/tmkms/config/secrets/priv_validator_key.key
CMD ["tmkms", "start", "--config", "./config/tmkms.toml"]
