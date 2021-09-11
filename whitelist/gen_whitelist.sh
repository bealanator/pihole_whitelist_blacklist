wget https://discourse.pi-hole.net/t/commonly-whitelisted-domains/212 -O pihole_common_whitelist.html
echo '#!/usr/bin/env bash' > common_whitelist_add.sh
grep "<code class" pihole_common_whitelist.html >> common_whitelist_add.sh
sed -i 's/<pre><code class="lang-auto">//' common_whitelist_add.sh
echo '#!/usr/bin/env bash' > common_whitelist_remove.sh
cat common_whitelist_add.sh | sed -e 's/-w/-w -d/' >> common_whitelist_remove.sh
