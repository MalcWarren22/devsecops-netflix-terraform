# ---- deps ----
FROM node:20-alpine AS deps
WORKDIR /app

# Enable Corepack so we use the project's Yarn (v4), not Yarn classic
RUN corepack enable

COPY package.json yarn.lock ./

# During migration, don't freeze. Once stable, you can switch back to --immutable.
RUN yarn install

# ---- build ----
FROM node:20-alpine AS build
WORKDIR /app
RUN corepack enable

COPY --from=deps /app/.yarn /app/.yarn
COPY --from=deps /app/.pnp.cjs /app/.pnp.cjs
COPY --from=deps /app/yarn.lock /app/yarn.lock
COPY --from=deps /app/package.json /app/package.json

COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN yarn build

# ---- run ----
FROM node:20-alpine AS run
WORKDIR /app
RUN corepack enable
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=build /app/package.json ./package.json
COPY --from=build /app/yarn.lock ./yarn.lock
COPY --from=build /app/next.config.* ./ 2>/dev/null || true
COPY --from=build /app/public ./public
COPY --from=build /app/.next ./.next
COPY --from=build /app/.yarn ./.yarn
COPY --from=build /app/.pnp.cjs ./.pnp.cjs

EXPOSE 3000
CMD ["yarn", "start"]
