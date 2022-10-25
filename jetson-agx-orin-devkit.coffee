deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

BOARD_PREPARE  = 'Put the NVidia Jetson AGX Orin board in recovery mode'
FLASH_TOOL = 'Unzip BalenaOS image and use <a href=\"https://github.com/balena-os/jetson-flash\">Jetson Flash</a> to provision the device.'
DONE_FLASHING  = 'After flashing is completed, please wait until the board is rebooted'
module.exports =
	version: 1
	slug: 'jetson-agx-orin-devkit'
	name: 'Nvidia Jetson AGX Orin Devkit'
	arch: 'aarch64'
	state: 'released'

	instructions: [
		BOARD_PREPARE
		FLASH_TOOL
		DONE_FLASHING
	]

	gettingStartedLink:
		windows: 'https://docs.balena.io/jetson-agx-orin-devkit/nodejs/getting-started/#adding-your-first-device'
		osx: 'https://docs.balena.io/jetson-agx-orin-devkit/nodejs/getting-started/#adding-your-first-device'
		linux: 'https://docs.balena.io/jetson-agx-orin-devkit/nodejs/getting-started/#adding-your-first-device'

	supportsBlink: false

	yocto:
		machine: 'jetson-agx-orin-devkit'
		image: 'balena-image'
		fstype: 'balenaos-img'
		version: 'yocto-kirkstone'
		deployArtifact: 'balena-image-jetson-agx-orin-devkit.balenaos-img'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 6
			path: '/config.json'

	initialization: commonImg.initialization
