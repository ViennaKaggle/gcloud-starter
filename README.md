# Keras and Tensorflow on Google Cloud using GPUs

## Create a free Google Cloud account

* 300$ free credits
* requires credit card

https://cloud.google.com/free/

## Using GPUs on Google Cloud

In order to attach GPUs to Google Cloud instances, one needs to upgrade the account. Please be aware, that after this point your credit may be charged with fees from your Google Cloud usage.

By default, ones quota for cloud GPUs is set to 0. Hence, we need to request a quota change for using a couple of GPUs.

https://console.cloud.google.com/compute/quotas

## Setup Google Cloud SDK

You can use the Google Cloud SDK right away directly in your browser.

To install it on your local machine, follow the guide on https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu?hl=de.

Create a project.

In this tutorial the project is called `deep-learning` and we will use the zone `europe-west1-b` (more information about which zones offer GPUs can be found on https://cloud.google.com/compute/docs/gpus/).

```
gcloud config set core/project deep-learning
gcloud config set compute/zone europe-west1-b
```
