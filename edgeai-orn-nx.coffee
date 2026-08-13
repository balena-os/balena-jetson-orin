deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg } = deviceTypesCommon

BOARD_PREPARE = 'Put the board in recovery mode'
FLASH_TOOL = 'Unzip BalenaOS image and use <a href="https://github.com/balena-os/jetson-flash">Jetson Flash</a> to provision the device.'
DONE_FLASHING = 'After flashing is completed, please wait until the board is rebooted'

module.exports =
	version: 1
	slug: 'edgeai-orn-nx'
	name: 'CompuLab EdgeAI-ORN NX 8GB/16GB'
	arch: 'aarch64'
	state: 'released'

	instructions: [ BOARD_PREPARE, FLASH_TOOL, DONE_FLASHING ]

	gettingStartedLink:
		windows: 'https://docs.balena.io/learn/getting-started/edgeai-orn/nodejs/'
		osx: 'https://docs.balena.io/learn/getting-started/edgeai-orn/nodejs/'
		linux: 'https://docs.balena.io/learn/getting-started/edgeai-orn/nodejs/'

	supportsBlink: false

	yocto:
		machine: 'edgeai-orn-nx'
		image: 'balena-image-flasher'
		fstype: 'balenaos-img'
		version: 'yocto-scarthgap'
		deployArtifact: 'balena-image-flasher-edgeai-orn-nx.balenaos-img'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
