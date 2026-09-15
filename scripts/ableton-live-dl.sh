#!/usr/bin/env bash

# currently supported flags: --lite, --intro, --standard, --suite
# couldn't find any exposed links for beta packages

BOLD="\e[1m"
RED="\e[31m"
END="\e[0m"

TYPE=${1#--}

get_download_url() {
	case "$TYPE" in
		lite|intro|standard|suite) ;;
		*) return 1 ;;
	esac
	
	BASE="https://cdn-downloads.ableton.com/channels"

	if [[ $# -eq 1 ]]; then
		echo "Determining latest version..." >&2
		for MINOR in {9..1}; do
			URL="$BASE/12.${MINOR}/ableton_live_${TYPE}_12.${MINOR}_64.zip"
			curl -fsI "$URL" >/dev/null || continue
			for POINT in {9..1}; do
				URL="$BASE/12.${MINOR}.${POINT}/ableton_live_${TYPE}_12.${MINOR}.${POINT}_64.zip"
				curl -fsI "$URL" >/dev/null && break
			done
			break
		done
	else
		echo "Searching for: $2" >&2
		URL="$BASE/$2$3${4:+$4}/ableton_live_${TYPE}_$2$3${4:+$4}_64.zip"
		if ! curl -fsI "$URL" >/dev/null 2>&1; then
			echo -e "${RED}Version $2$3${4:+$4} does not exist!${END}" >&2
			return 1
		fi
	fi
	curl -LsI -w '%{url_effective}' "$URL" | tail -n1
}

download_live() {
	DOWNLOAD_URL=$(get_download_url "$@") || exit 1
	VERSION=$(grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?' <<< "$DOWNLOAD_URL" | head -n1)
	echo -e "Downloading ${BOLD}Ableton Live $(echo "${VERSION}${END}...\n${DOWNLOAD_URL}" \
		| sed 's/?.*//')" 1>&2
	curl --create-dirs --output-dir $PWD \
		--remote-name -C - $DOWNLOAD_URL
}

download_live $@