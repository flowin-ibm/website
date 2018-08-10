#!/bin/bash
# Test availability and very basic content of flowing application routes.


if [ -z "$1" ]; then
    echo "usage: $0 HOSTNAME:PORT"
    echo "       $0 HOSTNAME"
    exit 1;
fi

echo "*** Flowing acceptance tests ***"

# Is the site available ?
echo "#A01 Test connectivity %> curl" $1"/"
curl -s $1/ &> /dev/null
if [ 0 == $? ]; then
    echo "#A01 SUCCESS connecting to server."
else
    echo "#A01 ERROR connecting to server.(" $? ")"
fi

# Does the site present the 'Flowin' page
echo "#A02 Test content of / %> curl" $1"/ |grep -i flowin"
curl -s $1/ |grep -i flowin &> /dev/null
if [ 0 == $? ]; then
    echo "#A02 SUCCESS receiving flowin root page."
else
    echo "#A02 ERROR receiving flowin root page.(" $? ")"
fi

