#!/bin/bash
$HOME/flutter/bin/flutter build web --release \
  --dart-define=APPWRITE_ENDPOINT=$APPWRITE_ENDPOINT \
  --dart-define=APPWRITE_PROJECT_ID=$APPWRITE_PROJECT_ID \
  --dart-define=APPWRITE_DATABASE_ID=$APPWRITE_DATABASE_ID \
  --dart-define=APPWRITE_API_KEY=$APPWRITE_API_KEY \
  --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY
