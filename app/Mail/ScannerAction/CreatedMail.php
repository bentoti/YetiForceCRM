<?php
/**
 * Base mail scanner action file.
 *
 * @package   App
 *
 * @copyright YetiForce Sp. z o.o
 * @license   YetiForce Public License 3.0 (licenses/LicenseEN.txt or yetiforce.com)
 * @author    Mariusz Krzaczkowski <m.krzaczkowski@yetiforce.com>
 */

namespace App\Mail\ScannerAction;

/**
 * Base mail scanner action class.
 */
class CreatedMail extends Base
{
	/**
	 * {@inheritdoc}
	 */
	public static $priority = 2;

	/**
	 * {@inheritdoc}
	 */
	public function process(): void
	{
	}
}
