#!/bin/bash

# Exit if no track name is provided
if [ -z "$1" ]; then
  echo "Usage: addsong <track name>"
  exit 1
fi

# Capture all arguments as the display title (e.g., "sign 4")
TITLE="$*"

# Strip spaces for the filename (e.g., "sign4")
FILENAME=$(echo "$TITLE" | tr -d ' ')

FILE="music.md"

# Find the line number of the closing </ul> tag
LINE=$(grep -n "</ul>" "$FILE" | tail -1 | cut -d: -f1)

if [ -z "$LINE" ]; then
  echo "Error: Could not find </ul> in $FILE"
  exit 1
fi

# Write everything before </ul> to a temporary file
head -n $((LINE-1)) "$FILE" > tmp.md

# Append the new track HTML block using TITLE and FILENAME
cat <<EOF >> tmp.md
  <li class="song-item">
    <span class="song-title">$TITLE</span>
    <div class="song-details">
      <img src="/assets/audio/$FILENAME.jpg" class="cover-art" onerror="this.style.display='none'">
      <div class="custom-player">
        <button class="play-toggle">play</button>
        <input type="range" class="progress-bar" value="0" max="100">
        <span class="time-display">0:00</span>
        <a href="/assets/audio/$FILENAME.mp3" download class="download-btn">↓</a>
      </div>
    </div>
    <audio preload="none">
      <source src="/assets/audio/$FILENAME.mp3" type="audio/mpeg">
    </audio>
  </li>
EOF

# Append </ul> and everything after it
tail -n +$LINE "$FILE" >> tmp.md

# Replace the original file
mv tmp.md "$FILE"

echo "Added '$TITLE' (file: $FILENAME.mp3) to $FILE"
