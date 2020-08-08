from flask_talisman import Talisman
from server import initialize_server, routes, csp, feature_policy
import sys

app = initialize_server()
talisman = Talisman(app,
                    content_security_policy=csp.csp,
                    content_security_policy_nonce_in=['script-src', 'style-src'],
                    feature_policy=feature_policy.feature_policy)

routes.configure(app, talisman)


if __name__ == '__main__':
    # This is used when running locally. Gunicorn is used to run the
    # application on Google App Engine. See entrypoint in app.yaml.

    # If the 'background' command line argument is given:
    #    python main.py background &
    # then run in non-debug mode, as debug mode can't be backgrounded
    # but debug mode is useful in general (as auto reloads on change)
    if len(sys.argv) > 1 and sys.argv[1] == 'background':
        # Turn off HTTPS redirects (automatically turned off for debug)
        talisman.force_https=False
        app.run(host='0.0.0.0', port=8080)
    else:
        app.run(host='0.0.0.0', port=8080, debug=True)
