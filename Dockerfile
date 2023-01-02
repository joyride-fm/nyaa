FROM haskell
RUN apt-get update
RUN apt-get install -y default-jre
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@9.1.2
WORKDIR /app
RUN npm install -g pnpm
WORKDIR /app/nyaa
COPY package.json package.json
COPY packages.dhall packages.dhall
COPY pnpm-lock.yaml pnpm-lock.yaml
COPY pnpm-workspace.yaml pnpm-workspace.yaml
COPY prod.dhall prod.dhall
COPY spago.dhall spago.dhall
COPY test.dhall test.dhall
COPY ffi ffi
RUN pnpm install
RUN npm install -g firebase-tools
RUN npm install -g firebase-functions
COPY . .
# intentional duplicate pnpm install
RUN pnpm install
RUN pnpm run build
CMD ["bash"]
