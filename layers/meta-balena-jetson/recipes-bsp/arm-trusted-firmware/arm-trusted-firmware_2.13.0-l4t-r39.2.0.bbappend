def generate_build_timestamp(d):
    import time
    sde = d.getVar('SOURCE_DATE_EPOCH')
    if sde:
        # time.gmtime converts epoch to UTC without needing the datetime.UTC object
        ts = time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(int(sde)))
        return 'BUILD_MESSAGE_TIMESTAMP="\\\"{}\\\""'.format(ts)
    return ''
