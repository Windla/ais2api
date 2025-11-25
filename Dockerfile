# syntax=docker/dockerfile:1
ARG NODE_VERSION=20

# --- Stage 1: Build dependencies ---
FROM node:${NODE_VERSION}-slim AS deps
WORKDIR /app
COPY package*.json ./
# Install production dependencies
RUN if [ -f package-lock.json ]; then npm ci --omit=dev; else npm install --omit=dev; fi

# --- Stage 2: Final runner image ---
FROM node:${NODE_VERSION}-slim AS runner
WORKDIR /app
ENV NODE_ENV=production \
    PLAYWRIGHT_BROWSERS_PATH=0

# Install runtime dependencies required by Firefox/Playwright, including unzip
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    fonts-liberation \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc-s1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download and place Camoufox (Linux build) into the expected directory
# The URL is passed as a build argument
ARG CAMOUFOX_URL
RUN set -ux; \
    mkdir -p /app/camoufox-linux; \
    curl -fsSL "$CAMOUFOX_URL" -o /tmp/camoufox.zip; \
    unzip -q /tmp/camoufox.zip -d /app/camoufox-linux; \
    # The zip file may contain a subdirectory, handle it if necessary
    if [ $(ls -1 /app/camoufox-linux | wc -l) -eq 1 ]; then \
      mv /app/camoufox-linux/$(ls -1 /app/camoufox-linux)/* /app/camoufox-linux/ && \
      rmdir /app/camoufox-linux/$(ls -1 /app/camoufox-linux | head -n 1); \
    fi; \
    chmod +x /app/camoufox-linux/camoufox* 2>/dev/null || true; \
    rm -rf /tmp/camoufox.zip

# Copy dependencies and source code
COPY --from=deps /app/node_modules ./node_modules
COPY unified-server.js black-browser.js models.json ./
# Create a non-root user and switch to it
RUN mkdir -p ./auth && chown -R 1000:1000 /app
USER 1000


# Set environment variables
ENV PORT=7860 \
    WS_PORT=9998 \
    HOST=0.0.0.0 \
    CAMOUFOX_EXECUTABLE_PATH=/app/camoufox-linux/camoufox

# Expose ports
EXPOSE 7860 9998

# Define container start command
CMD ["node", "unified-server.js"]
