.PHONY: tunnel
export HOST LOCAL_PORT REMOTE_PORT

tunnel:
	@for field in HOST LOCAL_PORT REMOTE_PORT; do \
		test -n "$$(printenv "$$field")" || { echo "Pass HOST, LOCAL_PORT and REMOTE_PORT explicitly." >&2; exit 1; }; \
	done
	@echo "Open https://localhost:$$LOCAL_PORT — keep this terminal open. Ctrl+C closes the tunnel."
	@ssh -N -T -o ExitOnForwardFailure=yes -o ServerAliveInterval=30 -o ServerAliveCountMax=3 \
		-L "127.0.0.1:$$LOCAL_PORT:127.0.0.1:$$REMOTE_PORT" -- "$$HOST"
