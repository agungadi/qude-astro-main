FROM node:20.18.1-alpine3.21 AS build

WORKDIR /app

RUN npm install -g pnpm
COPY package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile
COPY . .

RUN pnpm run build

FROM node:20.18.1-alpine3.21 AS runtime
WORKDIR /app

# Install pnpm in the runtime image
RUN npm install -g pnpm

# Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

# Copy built application
COPY --from=build /app/dist ./dist

ENV HOST=0.0.0.0
ENV PORT=3002
EXPOSE 3002

CMD ["pnpx", "serve", "-l", "tcp://0.0.0.0:3002", "dist"]