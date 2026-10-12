# syntax=docker/dockerfile:1
FROM rust:1-slim AS build
WORKDIR /src
COPY . .
RUN cargo build --release --locked

FROM gcr.io/distroless/cc-debian12:nonroot
COPY --from=build /src/target/release/app /app
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/app"]
