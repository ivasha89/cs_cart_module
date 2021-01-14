<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

use Tygh\Tygh;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'manage') {

    $where = [
        'L.type' => 'orders',
        'L.action' => 'status'
    ];
    $sql = db_quote(
        "SELECT L.type, L.action, L.user_id, L.content, L.timestamp, U.lastname, U.firstname "
        . "FROM ?:logs L "
        . "LEFT JOIN ?:users U "
        . "ON L.user_id = U.user_id "
        . "WHERE ?w", $where
    );
    $sql .= db_quote(" ORDER BY L.timestamp DESC");
    $logs = db_get_array($sql);
    foreach ($logs as $key => $log) {
        $logs[$key]['content'] = unserialize($log['content']);
    }

    $search = [
        'page' => 1,
        'items_per_page' => 10,
        'limit' => 0,
        'dispatch' => 'orders.history',
        'cc' => '',
        'sort_order' => 'desc',
        'sort_by' => 'timestamp',
        'sort_order_rev' => 'asc',
        'total_items' => count($logs)
    ];
    Tygh::$app['view']->assign([
        'logs'      => $logs,
        'search'    => $search,
        'log_types' => fn_get_log_types(),
    ]);
}