local yabs = safe_require('yabs')
if not yabs then
    return
end

local telescope = safe_require('telescope')
if not telescope then
    return
end


yabs:setup({
    languages = {
        -- Lua
        lua = {
            tasks = {
                run = {
                    command = 'luafile %',
                    type = 'lua',
                },
            },
        },
        -- Python
        python = {
            default_task = 'django_runserver',
            tasks = {
                run = {
                    command = 'python %',
                    output = 'terminal',
                },
                monitor = {
                    command = 'nodemon -e py %',
                    output = 'terminal',
                },
                django_runserver = {
                    command = 'python manage.py runserver',
                    output = 'quickfix',
                },
                django_shell = {
                    command = 'python manage.py shell',
                    output = 'terminal',
                },
                django_collect_static = {
                    command = 'python manage.py collectstatic',
                    output = 'terminal',
                },
                django_create_super_user = {
                    command = 'python manage.py createsuperuser',
                    output = 'terminal',
                },
                django_make_migrations = {
                    command = 'python manage.py makemigrations',
                    output = 'terminal',
                },
                django_migrate = {
                    command = 'python manage.py migrate',
                    output = 'terminal',
                },
                django_sql_migrate = {
                    command = 'python manage.py sqlmigrate',
                    output = 'terminal',
                },
            },
        },
        -- Others
    },
})

telescope.load_extension "yabs"
