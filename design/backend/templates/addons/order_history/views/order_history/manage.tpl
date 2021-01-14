{capture name="mainbox"}

{include file="common/pagination.tpl"}

{if $logs}
<div class="table-responsive-wrapper">
    <table class="table table--relative table-responsive">
    <thead>
        <tr>
            <th>{__("id")}</th>
            <th>{__("old_status")}</th>
            <th>{__("new_status")}</th>
            <th>{__("user")}</th>
            <th>{__("time")}</th>
        </tr>
    </thead>
    <tbody>
    {foreach from=$logs item="log"}
        <tr>
            <td class="wrap" data-th="{__("id")}">
                {foreach from=$log.content key="k" item="v"}
                {if $k == 'id'}
                    {__("order")} <bdi>#{$v}</bdi>
                {/if}
                {/foreach}
            </td>
                {foreach from=$log.content key="k" item="v"}
                {if $k == 'status'}
                {$statuses = explode('->',$v)}
                <td class="wrap" data-th="{__("old_status")}">
                    <p class="order-status">
                        {$statuses[0]}
                    </p>
                </td>
                <td class="wrap" data-th="{__("new_status")}">
                    <p class="order-status">
                        {$statuses[1]}
                    </p>
                </td>
                {/if}
                {/foreach}
            <td data-th="{__("user")}">
                {if $log.user_id}
                    <a href="{"profiles.update?user_id=`$log.user_id`"|fn_url}">{$log.lastname}{if $log.firstname || $log.lastname}&nbsp;{/if}{$log.firstname}</a>
                {else}
                    &mdash;
                {/if}
            </td>
            <td data-th="{__("time")}">
                <span class="nowrap">{$log.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</span>
            </td>
        </tr>
    {/foreach}
    </tbody>
    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl"}
{/capture}

{include file="common/mainbox.tpl" title="Журнал статусов" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons sidebar=$smarty.capture.sidebar}