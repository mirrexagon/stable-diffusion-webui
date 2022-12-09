#!/usr/bin/env bash

unison -auto -root "$(pwd)" -root "ssh://azurite//main-storage/main/shared/media/images/stable-diffusion/a1111" \
    -path outputs -path log -path textual_inversion -path embeddings

