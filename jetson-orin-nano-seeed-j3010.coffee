deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

BOARD_PREPARE  = 'Put the NVidia Jetson Orin Seeed J3010 in recovery mode'
FLASH_TOOL = 'Unzip BalenaOS image and use <a href=\"https://github.com/balena-os/jetson-flash\">Jetson Flash</a> to provision the device.'
DONE_FLASHING  = 'After flashing is completed, please wait until the board is rebooted'
module.exports =
	version: 1
	slug: 'jetson-orin-nano-seeed-j3010'
	name: 'Seeed ReComputer J3010'
	arch: 'aarch64'
	state: 'released'

	instructions: [
		BOARD_PREPARE
		FLASH_TOOL
		DONE_FLASHING
	]

	gettingStartedLink:
		windows: 'https://docs.balena.io/learn/getting-started/jetson-orin-nano-seeed-j3010/nodejs/'
		osx: 'https://docs.balena.io/learn/getting-started/jetson-orin-nano-seeed-j3010/nodejs/'
		linux: 'https://docs.balena.io/learn/getting-started/jetson-orin-nano-seeed-j3010/nodejs/'

	supportsBlink: false

	yocto:
		machine: 'jetson-orin-nano-seeed-j3010'
		image: 'balena-image-flasher'
		fstype: 'balenaos-img'
		version: 'yocto-kirkstone'
		deployArtifact: 'balena-image-flasher-jetson-orin-nano-seeed-j3010.balenaos-img'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
