FROM honeycombio/refinery:1.15.0 as builder
FROM alpine:latest
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /ko-app/refinery /bin/
ADD entrypoint.sh /
ADD config.toml /etc/refinery/refinery.toml
ADD rules.toml /etc/refinery/rules.toml
EXPOSE 9090
EXPOSE 8081
ENTRYPOINT ["/entrypoint.sh"]
CMD ["refinery"]
