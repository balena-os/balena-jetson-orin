deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

DONE_FLASHING  = 'After flashing is completed, please wait until the board is rebooted'
module.exports =
	version: 1
	slug: 'jetson-orin-nx-xavier-nx-devkit'
	name: 'Nvidia Jetson Orin NX in Xavier NX Devkit NVME'
	arch: 'aarch64'
	state: 'released'

	instructions: [
		DONE_FLASHING
	]

	gettingStartedLink:
		windows: 'https://docs.balena.io/jetson-orin-nx-xavier-nx-devkit/nodejs/getting-started/#adding-your-first-device'
		osx: 'https://docs.balena.io/jetson-orin-nx-xavier-nx-devkit/nodejs/getting-started/#adding-your-first-device'
		linux: 'https://docs.balena.io/jetson-orin-nx-xavier-nx-devkit/nodejs/getting-started/#adding-your-first-device'

	supportsBlink: false

	yocto:
		machine: 'jetson-orin-nx-xavier-nx-devkit'
		image: 'balena-image-flasher'
		fstype: 'balenaos-img'
		version: 'yocto-kirkstone'
		deployArtifact: 'balena-image-flasher-jetson-orin-nx-xavier-nx-devkit.balenaos-img'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
