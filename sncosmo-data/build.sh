
# convince astropy to stash files in the package itself
unset HOME
export XDG_CONFIG_HOME=${PREFIX}/etc
export XDG_CACHE_HOME=${PREFIX}/share/cache
mkdir -p $XDG_CONFIG_HOME/astropy
mkdir -p $XDG_CACHE_HOME/astropy

# instantiate filters and models, triggering download
python <<-EOF
import sncosmo
import logging
logging.basicConfig()
for band in 'ugriz':
    sncosmo.get_bandpass('sdss::{}'.format(band))
sncosmo.Model('salt2')
EOF

# set environment variables at runtime
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d
cp ${RECIPE_DIR}/activate_sncosmo.sh $PREFIX/etc/conda/activate.d
cp ${RECIPE_DIR}/deactivate_sncosmo.sh $PREFIX/etc/conda/deactivate.d
