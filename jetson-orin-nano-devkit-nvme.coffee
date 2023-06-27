deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

DONE_FLASHING  = 'After flashing is completed, please wait until the board is rebooted'
module.exports =
	version: 1
	slug: 'jetson-orin-nano-devkit-nvme'
	name: 'Nvidia Jetson Orin Nano 8GB (SD) Devkit NVME'
	arch: 'aarch64'
	state: 'released'

	instructions: [
		DONE_FLASHING
	]

	gettingStartedLink:
		windows: 'https://docs.balena.io/jetson-orin-nano-devkit-nvme/nodejs/getting-started/#adding-your-first-device'
		osx: 'https://docs.balena.io/jetson-orin-nano-devkit-nvme/nodejs/getting-started/#adding-your-first-device'
		linux: 'https://docs.balena.io/jetson-orin-nano-devkit-nvme/nodejs/getting-started/#adding-your-first-device'

	supportsBlink: false

	yocto:
		machine: 'jetson-orin-nano-devkit-nvme'
		image: 'balena-image-flasher'
		fstype: 'balenaos-img'
		version: 'yocto-kirkstone'
		deployArtifact: 'balena-image-flasher-jetson-orin-nano-devkit-nvme.balenaos-img'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
