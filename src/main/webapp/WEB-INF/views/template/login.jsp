<li>
    <a href="/user/profile"><i class="fa fa-fw fa-user"></i> Profile</a>
</li>
<li>
    <a href="/user/pass"><i class="fa fa-fw fa-unlock"></i> 비밀번호변경</a>
</li>
{{#if userRole}}
{{#compareTo userRole 'ADMIN'}}
<li>
    <a href="/user/signUp"><i class="fa fa-fw fa-user-plus"></i> Sign Up</a>
</li>
{{/compareTo}}
{{/if}}

{{!-- <li>
    <a href="/user/inbox"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
    <a href="/logoutUser"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
</li> --}}

<li class="divider"></li>

<li>
    <a href="#" id="btnLogOut"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
</li>