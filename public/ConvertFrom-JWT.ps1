Function ConvertFrom-JWT {
    [CmdletBinding()]
    [OutputType([string])]
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Token
    )

    begin {
        #region initialize Decoder Object
        $Serializer = [JWT.Serializers.JsonNetSerializer]::new()
        $Provider = [JWT.UtcDateTimeProvider]::new()
        $Validator = [JWT.JwtValidator]::new($Serializer, $provider)
        $Algorithm = [JWT.Algorithms.HMACSHA256Algorithm]::new()
        $UrlEncoder = [JWT.JwtBase64UrlEncoder]::new()

        $Decoder = [JWT.JwtDecoder]::new($Serializer, $Validator, $UrlEncoder, $Algorithm)
        #endregion
    }
    process {
        #region Decode JWT Token
        $result = $Decoder.Decode($token) | ConvertFrom-Json

        return $result
        #endregion
    }
    end {
        Remove-Variable -Name Decoder
    }
}