# Beispiel-App der Vorlage: ohne Abhängigkeiten zur Laufzeit, ohne Root, mit HEALTHCHECK.
# Basis-Image per Digest des Multi-Arch-Index gepinnt (wie in werkstatt), Updates über Dependabot.
FROM node:26-alpine@sha256:6bd9ab43c0ec0190ca7b2d193906cb8b7edf6e7f4afa43ddeccd6452710bffb5
ENV NODE_ENV=production PORT=3000
WORKDIR /app
COPY package.json ./
COPY src src
USER node
EXPOSE 3000
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null "http://127.0.0.1:${PORT}/health" || exit 1
CMD ["node", "src/main.ts"]
