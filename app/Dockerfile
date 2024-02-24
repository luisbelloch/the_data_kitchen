FROM golang:1.22-alpine as build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /kitchen
COPY docs /docs

FROM scratch
COPY --from=build /kitchen .
COPY --from=build /docs /docs
EXPOSE 3000
CMD ["./kitchen"]
