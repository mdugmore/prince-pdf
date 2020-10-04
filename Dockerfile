FROM debian:buster-slim
ARG PRINCE_VERSION=13.5
ARG DEBIAN_VERSION=10
ARG DEB_FILE=prince_${PRINCE_VERSION}-1_debian${DEBIAN_VERSION}_amd64.deb

RUN apt-get update && apt-get install --no-install-recommends -y \
      curl \
      ca-certificates \
      fonts-tlwg-garuda-otf \
      fonts-lohit-orya \
      fonts-lohit-mlym \
      fonts-lohit-knda \
      fonts-lohit-telu \
      fonts-lohit-taml \
      fonts-lohit-gujr \
      fonts-lohit-guru \
      fonts-lohit-beng-bengali \
      fonts-lohit-deva \
      fonts-baekmuk \
      fonts-ipafont-mincho \
      fonts-arphic-uming \
      fonts-opensymbol \
      fonts-liberation2 && \
    curl --proto '=https' --tlsv1.2 -O https://www.princexml.com/download/${DEB_FILE} && \
    apt-get install -y ./${DEB_FILE} && \
    rm ${DEB_FILE} && \
    apt-get purge -y curl && \
    apt-get autoremove -y && apt-get clean && \
    ln -sf /etc/ssl/certs/ca-certificates.crt /usr/lib/prince/etc/curl-ca-bundle.crt

ENTRYPOINT ["prince"]

CMD ["--help"]

# To build:
# docker build --tag princepdf:1 .
# To run use command:
# docker run --rm -it -v ${pwd}:/out princepdf:1 /out/samples/example.html -o /out/samples/example.pdf