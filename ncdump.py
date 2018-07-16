#!/usr/bin/env python

import os
import sys
import numpy as np
from netCDF4 import Dataset

def print_dims(ds):
    s = 'dimensions:\n'
    for k, v in ds.dimensions.items():
        s += '    %s = %s\n' % (k, v.size)
    sys.stdout.write(s)

def get_attr(attr_name):
    try:
        return attr_name
    except AttributeError:
        return ''
    finally:
        return ''

def print_vars(ds):
    sys.stdout.write('variables:\n')
    for name, data in ds.variables.items():

        long_name = get_attr(data.long_name)
        units     = get_attr(data.units)
        ndim      = get_attr(data.ndim)
        fill_val  = get_attr(data._FillValue)

        '''
        try:
            long_name = data.long_name
        except AttributeError:
            long_name = ''

        try:
            units = data.units
        except AttributeError:
            units = ''

        try:
            ndim = data.ndim
        except AttributeError:
            ndim = ''

        try:
            fill_val = data._FillValue
        except AttributeError:
            fill_val = ''
        '''

        dtype = data.dtype
        shape = data.shape
        if not shape:
            shape = ''

        desc  = '    %s %s%s:\n' % (dtype, name, shape)
        if long_name:
            desc += '        long_name:  %-45s\n' % (long_name)
        if units:
            desc += '        units:      %-45s\n' % (units)
        if ndim:
            desc += '        ndim:       %-45s\n' % (ndim)
        if fill_val:
            desc += '        _FillValue: %-45s\n' % (fill_val)

        scalar_dtype = False
        scalar_value = None
        if len(shape) == 1 and np.isscalar(data):
            scalar_dtype = True
            scalar_value = data[0]

        if scalar_dtype:
            desc += '        value:      %-45s\n' % (scalar_value)

        sys.stdout.write(desc)

# ----------------------------------------------------------------------------
# name:
#     print_attr
#
# description:
#     Prints all of the global attributes to the console
#
# parameters:
#     ds   An initialized instance of netCDF4.Dataset
#
# return:
#     None
# ----------------------------------------------------------------------------
def print_attr(ds):
    attrs = ''
    for name in ds.ncattrs():
        attrs += '        :%s = %s\n' % (name, getattr(ds, name))
    attrs += '\n'
    sys.stdout.write('\n// global attributes:\n%s' % attrs)

def ncdump(ncfile):
    try:
        ds = Dataset(ncfile, 'r')
    except IOError:
        print '**** error opening input file: %s' % ncfile
        sys.exit(1)

    name, _ = os.path.splitext(os.path.basename(ncfile))
    sys.stdout.write('netcdf %s {\n' % name)
    print_dims(ds)
    print_vars(ds)
    print_attr(ds)
    sys.stdout.write('}\n')

def main(argc, argv):
    if argc != 2:
        print 'Usage: %s <netcdf-file>' % os.path.basename(argv[0])
        sys.exit(1)

    ncfile = argv[1]
    ncdump(ncfile)

if __name__ == '__main__':
    main(len(sys.argv), sys.argv)
