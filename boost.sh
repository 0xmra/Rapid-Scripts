#!/bin/bash

echo "⚡ TEMPORARY BOOST: Starting safe optimization..."

# 1. Set CPU governors to performance (boost CPU speed temporarily)
echo "→ Setting CPU governors to performance mode..."
for CPU in /sys/devices/system/cpu/cpu[0-9]*; do
    GOV="$CPU/cpufreq/scaling_governor"
    if [ -f "$GOV" ]; then
        echo performance | sudo tee "$GOV" > /dev/null
    fi
done

# 2. Drop RAM caches (safe memory flush)
echo "→ Dropping memory caches (freeing unused RAM)..."
sync
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

# 3. Reduce swappiness temporarily (prefer RAM over swap)
echo "→ Setting vm.swappiness to 10 (temporary)..."
sudo sysctl vm.swappiness=10

# 4. Flush file system buffers
echo "→ Syncing file system (write buffers to disk)..."
sync

# 5. Optional: Clear old journal logs (non-critical cleanup)
echo "→ Cleaning old journal logs (safe)..."
sudo journalctl --vacuum-time=1d > /dev/null

echo "✅ TEMPORARY BOOST COMPLETE!"
echo "You may now enjoy smoother performance until next reboot."
