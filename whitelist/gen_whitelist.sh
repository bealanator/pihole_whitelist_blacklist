wget https://discourse.pi-hole.net/t/commonly-whitelisted-domains/212 -O $(pwd)/whitelist/pihole_common_whitelist.html
echo '#!/usr/bin/env bash' > $(pwd)/whitelist/common_whitelist_add.sh
grep "<code class" $(pwd)/whitelist/pihole_common_whitelist.html >> $(pwd)/whitelist/common_whitelist_add.sh
sed -i 's/<pre><code class="lang-auto">//' $(pwd)/whitelist/common_whitelist_add.sh
echo '#!/usr/bin/env bash' > $(pwd)/whitelist/common_whitelist_remove.sh
cat $(pwd)/whitelist/common_whitelist_add.sh | sed -e 's/-w/-w -d/' >> $(pwd)/whitelist/common_whitelist_remove.sh
