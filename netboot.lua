local function doList(targetDir, url, headers)
    print("Fetching listing:")
    print(url.. '/listing.txt')

    local listing, err = http.get({
        url = (url.. '/listing.txt'),
        headers = headers,
    })

    if err then
        return err
    end

    print("Downloading:")

    while true do
        local line = listing.readLine()

        if not line then break end

        write('- ')
        print(line)

        local file, err = http.get({
            url = (url.. '/' .. line),
            headers = headers,
            binary = true,
        })

        local output
        output, err = fs.open(fs.combine(targetDir, line), "wb")

        if err then
            return err
        end

        output.write(file.readAll() or '')
        output.close()
        file.close()
    end

    listing.close()
end

return function(targetDir, url, headers, clean)
    assert(type(url) == "string", "url must be a string")
    assert(type(headers) == "table" or headers == nil, "headers must be a table or nil")

    clean = clean or false
    targetDir = string.gsub(targetDir, '^\/*', '/')

    print("Netboot")

    if clean then
        fs.delete(targetDir)
    end

    doList(targetDir, url, headers)

    local target = targetDir.."/startup.lua"

    print("Launching "..target)

    shell.run(target)
end
